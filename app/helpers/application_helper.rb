module ApplicationHelper
  include Pagy::Frontend
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def worked_hours(time, project)
    project_timing = project.timings.where(surveyor_id: current_user.id, date: time.midnight..time.end_of_day).first
    if project_timing.present?
      hours = project_timing.total_duration
      hours
    else
      nil
    end
  end

  def find_timing_id(time, project)
    project_timing = project.timings.where(surveyor_id: current_user.id, date: time.midnight..time.end_of_day).first.id
    project_timing
  end

  def calculate_total(time)
    total = current_user.timings.where(date: time.midnight..time.end_of_day).pluck(:total_duration).sum
    total
  end
end
