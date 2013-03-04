name 'rest_tail'
description 'Nginx/Unicorn for rest-tail app'
run_list(
  'recipe[apt]',
  'recipe[build-essential]',
  'recipe[ruby_build]',
  'recipe[rbenv::system]',
  'recipe[sudo]',
  'recipe[application_rest-tail]'
)

default_attributes(
  'build-essential' => {
    'compiletime' => true
  },
  :authorization => {
    :sudo => {
      :groups => [],
      :users => ['trotttrotttrott', 'travis'],
      :passwordless => true
    }
  },
  :rbenv => {
    :rubies => [
      '2.0.0-p0'
    ],
    :global => '2.0.0-p0',
    :gems => {
      '2.0.0-p0' => [
        :name => 'bundler'
      ]
    }
  }
)
