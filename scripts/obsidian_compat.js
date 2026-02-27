const fs = require('fs');
const path = require('path');

// 监听 Hexo 在生成前，对 Markdown 进行预处理
hexo.extend.filter.register('before_post_render', function(data) {
    if (!data.content) return data;

    // 1. 兼容 Obsidian 图片语法: ![[图片名.png]] -> {% asset_img 图片名.png %} 或 markdown [图片名.png](图片名.png)
    // 假设您将图片统一放在 source/images/ 或与文档同名的 _posts 文件夹下。
    // 这里将其转换为 Markdown 标准语法相对路径，前提是已在 _config.yml 开启 post_asset_folder: true
    data.content = data.content.replace(/!\[\[(.*?)\]\]/g, '![]($1)');

    // 2. 兼容 Obsidian 内链: [[文章名]] -> [文章名](文章名/) (粗略替换，建议直接用标准 md 链接)
    data.content = data.content.replace(/\[\[(.*?)\]\]/g, '[$1]($1)');

    return data;
});