class Project < ActiveRecord::Base

  has_and_belongs_to_many  :organizations

  # Pagination -> number of records per page
  paginates_per 50

  # Basic order method
  def self.order_by(sort_col, sort_dir)
    self.all.order("#{sort_col} #{sort_dir}")
  end


end
