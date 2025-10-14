local schemas = {
  gitlab = {
    ci = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
  },
}

return {
  settings = {
    yaml = {
      keyOrdering = false,
      schemas = {
        [schemas.gitlab.ci] = {
          'gitlab-ci.yml',
          '.gitlab/*.yml',
        },
      },
    },
  },
}
