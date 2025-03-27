local schemas = {
  gitlab = {
    ci = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
    reporter = 'https://gitlab.com/gitlab-newscast/reporter/-/raw/main/reporter/lib/config/schema.json',
  },
}

return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  single_file_support = true,
  init_options = {
    keyOrdering = false,
    schemas = {
      [schemas.gitlab.ci] = {
        'gitlab-ci.yml',
        '.gitlab/*.yml',
      },
      [schemas.gitlab.reporter] = 'reports.*.yml',
    },
  },
}
