module ActivityLogsHelper

  def options_babies_select(babies)
    raw babies.map {|n| content_tag(:option, value: n.id) { n.name } }.join
  end

  def options_assistants_select(assistants)
    raw assistants.map {|n| content_tag(:option, value: n.id) { n.name } }.join
  end

  def status_activity(stop_time)
    (stop_time && t(:finished) || t(:in_progress))
  end

  def duration_activity(duration)
    (duration && "#{duration} #{t(:minutes)}" || t(:ast))
  end
end