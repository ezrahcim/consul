<<<<<<< HEAD
class Valuation::Budgets::RowComponent < ApplicationComponent
  attr_reader :budget
  with_collection_parameter :budget

  delegate :current_user, to: :helpers

  def initialize(budget:)
    @budget = budget
  end

  def investments
    return Budget::Investment.none unless budget.valuating?

    budget.investments.visible_to_valuators.by_valuator(current_user.valuator).valuation_open
  end
end
=======
class Valuation::Budgets::RowComponent < ApplicationComponent
  attr_reader :budget
  with_collection_parameter :budget

  delegate :current_user, to: :helpers

  def initialize(budget:)
    @budget = budget
  end

  def investments
    return Budget::Investment.none unless budget.valuating_or_later?

    budget.investments.visible_to_valuator(current_user.valuator)
  end

  def valuation_open_investments_count
    return 0 unless budget.valuating?

    investments.valuation_open.count
  end
end
>>>>>>> 33c62ccbd7c08c99604903bc8f983f3e706ed21d
