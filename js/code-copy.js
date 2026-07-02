/**
 * 代码复制按钮功能
 * 为所有代码块添加复制按钮，方便读者复制代码
 */
(function() {
  'use strict';

  // 等待DOM加载完成
  document.addEventListener('DOMContentLoaded', function() {
    // 查找所有代码块
    const codeBlocks = document.querySelectorAll('pre code, pre.highlight');
    
    codeBlocks.forEach(function(codeBlock) {
      // 获取父元素 pre
      const pre = codeBlock.tagName === 'PRE' ? codeBlock : codeBlock.parentElement;
      
      // 创建容器
      const container = document.createElement('div');
      container.className = 'code-container';
      container.style.position = 'relative';
      container.style.marginBottom = '1rem';
      
      // 将 pre 包装在容器中
      pre.parentNode.insertBefore(container, pre);
      container.appendChild(pre);
      
      // 创建复制按钮
      const copyButton = document.createElement('button');
      copyButton.className = 'copy-code-button';
      copyButton.type = 'button';
      copyButton.innerHTML = '📋 复制';
      copyButton.style.cssText = `
        position: absolute;
        top: 8px;
        right: 8px;
        padding: 4px 12px;
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid #ddd;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
        transition: all 0.3s;
        z-index: 10;
      `;
      
      // 鼠标悬停效果
      copyButton.addEventListener('mouseenter', function() {
        this.style.background = '#4A90E2';
        this.style.color = 'white';
        this.style.borderColor = '#357ABD';
      });
      
      copyButton.addEventListener('mouseleave', function() {
        this.style.background = 'rgba(255, 255, 255, 0.9)';
        this.style.color = '#333';
        this.style.borderColor = '#ddd';
      });
      
      // 点击复制事件
      copyButton.addEventListener('click', function() {
        const code = codeBlock.textContent || codeBlock.innerText;
        
        // 使用现代 Clipboard API
        if (navigator.clipboard && navigator.clipboard.writeText) {
          navigator.clipboard.writeText(code).then(function() {
            showCopySuccess(copyButton);
          }).catch(function(err) {
            console.error('复制失败:', err);
            fallbackCopy(code, copyButton);
          });
        } else {
          // 降级方案
          fallbackCopy(code, copyButton);
        }
      });
      
      // 添加按钮到容器
      container.appendChild(copyButton);
    });
  });
  
  // 显示复制成功提示
  function showCopySuccess(button) {
    const originalText = button.innerHTML;
    button.innerHTML = '✅ 已复制';
    button.style.background = '#5cb85c';
    button.style.color = 'white';
    button.style.borderColor = '#4cae4c';
    
    setTimeout(function() {
      button.innerHTML = originalText;
      button.style.background = 'rgba(255, 255, 255, 0.9)';
      button.style.color = '#333';
      button.style.borderColor = '#ddd';
    }, 2000);
  }
  
  // 降级复制方案（兼容旧浏览器）
  function fallbackCopy(text, button) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    textarea.style.position = 'fixed';
    textarea.style.left = '-9999px';
    document.body.appendChild(textarea);
    textarea.select();
    
    try {
      document.execCommand('copy');
      showCopySuccess(button);
    } catch (err) {
      console.error('降级复制也失败:', err);
      button.innerHTML = '❌ 失败';
      setTimeout(function() {
        button.innerHTML = '📋 复制';
      }, 2000);
    }
    
    document.body.removeChild(textarea);
  }
})();