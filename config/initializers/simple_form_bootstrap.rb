SimpleForm.setup do |config|
  # you need an updated simple_form gem for this to work, I'm referring to the git repo in my Gemfile
  config.input_class = "form-control"

  config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'help-inline text-danger' }
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :group, tag: 'div', class: "form-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.use :input, wrap_with: { class: "input-group" }
    b.use :hint, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
  end

  config.default_wrapper = :bootstrap
end