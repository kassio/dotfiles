return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    -- html
    'erb',
    'eruby', -- vim ft
    'haml',
    'html',
    'markdown',
    -- css
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    -- js
    'javascript',
    -- mixed
    'vue',
    'svelte',
    'templ',
  },
}
