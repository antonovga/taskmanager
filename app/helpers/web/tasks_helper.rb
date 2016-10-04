module Web::TasksHelper

  def render_task_attachment(task)
    return unless task.attachment.file

    if MIME::Types.type_for(task.attachment.file.path).first&.media_type == 'image'
      image_tag task.attachment.url
    else
      link_to task.attachment.file.filename, download_user_task_attachment_path(task)
    end
  end

  def render_task_state_links(task)
    capture do
      task.aasm.events(permitted: true)&.map(&:name).each do |event|
        concat link_to(event, url_for([event, :user, task]), method: :patch)
      end
    end
  end
end
