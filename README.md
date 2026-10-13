# 知序 · GitHub Pages + Supabase

此版本将公开页面和编辑器统一接入 Supabase。GitHub Pages 仍只负责静态托管；文章存储、登录与权限由 Supabase 提供。

## 包含文件
- `index.html`：首页与最近发布文章
- `articles.html`：公开文章列表、搜索、分类筛选
- `article.html`：公开文章详情，支持 Markdown 与 LaTeX
- `editor.html`：邮箱密码登录、加载文章、新建/编辑、保存草稿、发布
- `supabase.js`：Supabase 项目 URL 和 Publishable key
- `zhixu.js`：公共查询与格式化工具
- `supabase-setup.sql`：数据库与 RLS 初始化
- `migrate-existing-articles.sql`：导入原 `articles.json` 示例文章的可选脚本
- `articles.json`：原始数据备份参考；页面不再从它读取文章

## 部署步骤（按顺序）

### 1. 创建管理员用户
Supabase Dashboard → Authentication → Users → Add user，创建你自己的邮箱密码用户。记下该用户的 UUID。建议关闭公开注册（Authentication 的 Sign In / Providers 或 Auth settings 中的 Allow new users to sign up），网站不提供注册入口。

### 2. 初始化数据库与 RLS
打开 `supabase-setup.sql`，将所有 `YOUR-USER-UUID` 替换为管理员真实 UUID（共 5 处），复制到 Supabase SQL Editor 并运行。脚本会创建 `public.articles` 表、启用 RLS，并设置访客只读已发布文章、指定管理员可管理文章的策略。不要关闭 RLS。

### 3. 可选：导入旧示例文章
如果想保留旧 `articles.json` 中的两篇示例文章，打开 `migrate-existing-articles.sql`，把 `YOUR-USER-UUID` 替换为同一个管理员 UUID 后运行。此脚本将示例文章作为已发布文章导入；若不需要示例文章，跳过即可。若 slug 已存在，脚本不会覆盖现有文章。

### 4. 配置 Auth URL
Supabase Dashboard → Authentication → URL Configuration：
- Site URL：`https://r4vks88t5k-sys.github.io/zhixu/`
- Redirect URLs 添加：`https://r4vks88t5k-sys.github.io/zhixu/**`

### 5. 上传网页
把此文件夹中的所有文件（不是外层文件夹本身）上传到 GitHub 仓库 `zhixu` 的 `main` 分支根目录，覆盖原有同名 HTML，并新增 `supabase.js`、`zhixu.js`、SQL 文件等。GitHub Pages 继续使用 `main` / `/(root)`。等待部署完成后强制刷新页面。

### 6. 测试
1. 访问首页和文章列表：只应显示 `status = 'published'` 的文章。
2. 打开 `editor.html`，用第 1 步的管理员邮箱密码登录。
3. 新建文章，填写标题、slug、分类、摘要和正文，点击“保存草稿”。
4. 选择文章再次打开，确认可编辑；点击“发布文章”后检查公开列表和详情页。
5. 退出登录，确认不能保存或发布。用无痕窗口确认访客无法读取草稿。

## 安全说明
- `sb_publishable_...` 是前端公开密钥，可以放在 HTML/JS 中；真正的保护由 RLS 策略提供。
- **不要**把 `sb_secret_...`、`service_role`、数据库密码放进网站文件或公开仓库。
- 管理员 UUID 是用于策略的标识符，不是密码；权限仍由 Supabase Auth JWT + RLS 检查。
- 文章公开与否由 `status` 控制；公开页面只查询 `published`，数据库策略也限制访客只读已发布文章。
- 本包使用 CDN 加载 Supabase JS、Marked、DOMPurify 和 KaTeX，因此用户浏览器需要能访问这些 CDN。
- 这是个人管理员版：只有初始化 SQL 中指定的一个用户可以管理所有文章。如以后增加作者或协作者，需要重新设计策略。

## 常见问题
- **页面提示 permission denied / RLS**：确认 SQL 中的 UUID 与 Authentication → Users 中管理员 UUID 完全一致；确认已运行初始化脚本。
- **登录成功但没有文章**：检查是否执行可选导入脚本；空表时这是正常现象。
- **文章保存失败 slug duplicate**：每篇文章的 `slug` 必须唯一。
- **登录跳转或确认邮件异常**：检查 Auth URL Configuration 的 Site URL 和 Redirect URLs。
- **旧页面还在显示**：等待 Pages 构建完成并使用 Ctrl+F5 强制刷新。
