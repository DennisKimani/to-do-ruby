class Task < ActiveRecord::Base
  belongs_to(:list)
  scope(:not_done, -> do
    where(done: false)
  end)
#  validates(:description, :presence => true)
  validates(:description, {:presence => true, :length => { :maximum => 50 }})
  before_save(:downcase_description)

  private

  define_method(:downcase_description) do
    self.description=(description().downcase())
  end
  end
