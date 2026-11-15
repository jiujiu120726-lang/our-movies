# After the Credits · 朋友共享电影俱乐部

## 立即上线（约 15–25 分钟）

**本压缩包是可部署的网站，不是已经发布的公网网址。** 为了让朋友们共享数据，需要自己的 Supabase 项目和静态托管网站。

1. 打开 https://supabase.com 创建项目。
2. 进入项目的 SQL Editor，粘贴 `schema.sql` 全文，点击 Run（只在新项目执行一次）。这会建立电影表、图片存储及开放式协作权限。
3. 在 Supabase 项目设置/API 或 Connect 中复制 **Project URL** 和 **publishable/anon key**，填写 `config.js` 的两处占位文字。**绝不能填写 secret/service_role key。**
4. 把 `index.html` 和填写后的 `config.js` 放在同一个文件夹中（可连同 README、SQL 一起保留）。打开 https://app.netlify.com/drop ，拖入这个文件夹，Netlify 会生成一个 HTTPS 网站地址。
5. 把地址分享给朋友。打开同一网址，就可以查看和编辑同一份电影片单。

## 已实现
添加电影、年份、推荐人、推荐理由、JPEG 图片上传、搜索、想看/已看筛选、随机抽片、修改状态、删除电影、实时订阅更新。

## 注意
- **这是开放协作版**：拿到网址或公开数据库访问参数的人可以读写和删除记录；不适合私人敏感内容。若需仅受邀成员可修改，下一步应加 Supabase Auth + 限制性 RLS。
- 图片公开可访问，上传自己有权分享的图片。
- 图片原文件需不超过 5MB；网页会转为 JPEG。
- Supabase 脚本依赖 jsDelivr CDN；如果使用网络环境无法访问该 CDN，需要改为本地托管依赖。
- `index.html` 直接双击也能看页面，但**未填数据库配置时不能共享或保存数据**。
