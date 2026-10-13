# 知序 · GitHub Pages 静态站点

## 文件说明

- `index.html`：首页
- `articles.html`：文章列表、搜索与分类筛选
- `article.html`：单篇文章阅读页，支持 Markdown 与 LaTeX
- `editor.html`：Markdown/LaTeX 编辑器
- `articles.json`：公开文章数据源
- `.nojekyll`：避免 GitHub Pages 对文件执行 Jekyll 处理

## 发布到 GitHub Pages

1. 在 GitHub 新建一个仓库，例如 `zhixu`。
2. 将以上文件和 `.nojekyll` 上传到仓库根目录（不要把它们再放进子文件夹）。
3. 打开仓库 `Settings → Pages`。
4. 在 `Build and deployment` 中选择 `Deploy from a branch`，分支选 `main`，目录选 `/(root)`，保存。
5. 等待部署完成后，访问 `https://你的用户名.github.io/zhixu/`。若仓库名不是 `zhixu`，网址中的路径也要相应修改。

## 重要说明

- 这是静态网站，文章内容存放在公开的 `articles.json` 中；放入仓库的文章会对公众可见。不要把密码、密钥或不想公开的草稿提交到仓库。
- 编辑器当前只将内容保存在当前浏览器的 `localStorage` 中。“保存”不等于发布，不会自动修改 `articles.json`，也不会跨设备同步。
- 要发布新文章，需要手动编辑 `articles.json` 并提交到 GitHub；若希望在网页编辑器中登录后直接云端发布，需要后续接入后端/数据库和权限控制。
- Markdown/LaTeX 渲染依赖 jsDelivr CDN，浏览器需要能够访问互联网。
- 建议通过 GitHub Pages 或本地 HTTP 服务器预览；直接双击 HTML 打开时，浏览器可能阻止读取 `articles.json`。
