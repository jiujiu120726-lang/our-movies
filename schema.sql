-- Run once in Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.films (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 100),
  year integer check (year between 1880 and 2100),
  recommended_by text not null default '' check (char_length(recommended_by) <= 50),
  note text not null default '' check (char_length(note) <= 400),
  status text not null default 'watchlist' check (status in ('watchlist','watched')),
  image_path text,
  created_at timestamptz not null default now()
);
alter table public.films enable row level security;
create policy "Shared film club read" on public.films for select to anon using (true);
create policy "Shared film club add" on public.films for insert to anon with check (true);
create policy "Shared film club edit" on public.films for update to anon using (true) with check (true);
create policy "Shared film club remove" on public.films for delete to anon using (true);
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('film-images','film-images',true,5242880,array['image/jpeg'])
on conflict (id) do nothing;
create policy "Film image view" on storage.objects for select to public using (bucket_id='film-images');
create policy "Film image upload" on storage.objects for insert to anon with check (bucket_id='film-images' and lower(storage.extension(name))='jpg');
create policy "Film image remove" on storage.objects for delete to anon using (bucket_id='film-images');
-- Enable realtime publication for films (safe to rerun):
do $$ begin
  alter publication supabase_realtime add table public.films;
exception when duplicate_object then null;
end $$;
