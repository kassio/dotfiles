local gitlab_schema =
  'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'

return {
  settings = {
    yaml = {
      keyOrdering = false,
    },
    [gitlab_schema] = '/.gitlab-ci.yml',
  },
}
