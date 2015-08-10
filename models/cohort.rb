class Cohort < ActiveRecord::Base
  self.table_name = :view_cohorts

  def format_cohort_date(opts = {})
    if opts[:header]
      self.cohort_date.strftime('%-m/%-d/%Y')
    else
      self.cohort_date.strftime('%-m&#8209;%-d')
    end
  end
end
