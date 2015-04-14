class Project < ActiveRecord::Base

  has_and_belongs_to_many  :organizations

  # Pagination -> number of records per page
  paginates_per 50


end
