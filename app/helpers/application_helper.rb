module ApplicationHelper
  def flash_classes(level)
    classes = ['alert', 'alert-dismissable']
    classes <<
      case level.to_s
        when 'error' then 'alert-danger'
        when 'success' then 'alert-success'
        when 'alert', 'warn' then 'alert-warning'
        when 'info' then 'alert-info'
      end

    classes.join(' ').strip
  end
end
