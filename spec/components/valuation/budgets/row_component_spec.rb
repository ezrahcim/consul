<<<<<<< HEAD
require "rails_helper"

describe Valuation::Budgets::RowComponent do
  let(:valuator) { create(:valuator) }

  before { sign_in(valuator.user) }

  it "Displays visible and assigned investments count when budget is in valuating phase" do
    budget = create(:budget, :valuating, name: "Sports")
    create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])
    create(:budget_investment, :invisible_to_valuators, budget: budget, valuators: [valuator])
    create(:budget_investment, :visible_to_valuators, budget: budget)

    render_inline Valuation::Budgets::RowComponent.new(budget: budget)

    expect(page).to have_selector(".investments-count", text: "1")
  end

  it "Displays zero as investments count when budget is not in valuating phase" do
    budget = create(:budget, %i[accepting finished].sample, name: "Sports")
    create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])

    render_inline Valuation::Budgets::RowComponent.new(budget: budget)

    expect(page).to have_selector(".investments-count", text: "0")
  end

  it "Displays the link to evaluate investments when valuator has visible investments assigned and budget is
      in valuating phase" do
    valuating = create(:budget, :valuating)
    create(:budget_investment, :visible_to_valuators, budget: valuating, valuators: [valuator])
    valuating_invisible = create(:budget, :valuating)
    create(:budget_investment, :invisible_to_valuators, budget: valuating_invisible, valuators: [valuator])
    valuating_unassigned = create(:budget, :valuating)
    create(:budget_investment, :visible_to_valuators, budget: valuating_unassigned)
    accepting = create(:budget, :accepting)
    create(:budget_investment, :visible_to_valuators, budget: accepting, valuators: [valuator])
    finished = create(:budget, :finished)
    create(:budget_investment, :visible_to_valuators, budget: finished, valuators: [valuator])
    budgets = [valuating, valuating_invisible, valuating_unassigned, accepting, finished]

    render_inline Valuation::Budgets::RowComponent.with_collection(budgets)

    expect(page.find("#budget_#{valuating.id}")).to have_link("Evaluate")
    expect(page.find("#budget_#{valuating_invisible.id}")).not_to have_link("Evaluate")
    expect(page.find("#budget_#{valuating_unassigned.id}")).not_to have_link("Evaluate")
    expect(page.find("#budget_#{accepting.id}")).not_to have_link("Evaluate")
    expect(page.find("#budget_#{finished.id}")).not_to have_link("Evaluate")
  end
end
=======
require "rails_helper"

describe Valuation::Budgets::RowComponent do
  let(:valuator) { create(:valuator) }

  before { sign_in(valuator.user) }

  describe "investments count" do
    it "counts visible and assigned investments when the budget is in the valuating phase" do
      budget = create(:budget, :valuating)
      create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])
      create(:budget_investment, :invisible_to_valuators, budget: budget, valuators: [valuator])
      create(:budget_investment, :visible_to_valuators, budget: budget)

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_selector ".investments-count", text: "1"
    end

    it "counts investments assigned to the valuator group" do
      budget = create(:budget, :valuating)
      valuator_group = create(:valuator_group, valuators: [valuator])
      create(:budget_investment, :visible_to_valuators, budget: budget, valuator_groups: [valuator_group])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_selector ".investments-count", text: "1"
    end

    it "does not count investments with valuation finished" do
      budget = create(:budget, :valuating)
      create(:budget_investment, :visible_to_valuators,
                                 budget: budget,
                                 valuators: [valuator],
                                 valuation_finished: true)

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_selector ".investments-count", text: "0"
    end

    it "displays zero when the budget hasn't reached the valuating phase" do
      budget = create(:budget, :accepting)
      create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_selector ".investments-count", text: "0"
    end

    it "displays zero when the valuating phase is over" do
      budget = create(:budget, :finished)
      create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_selector ".investments-count", text: "0"
    end
  end

  describe "link to evaluate investments" do
    it "is shown when the valuator has visible investments assigned in the valuating phase" do
      budget = create(:budget, :valuating)
      create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_link "Evaluate"
    end

    it "is shown when the investments are assigned to the valuator group" do
      budget = create(:budget, :valuating)
      valuator_group = create(:valuator_group, valuators: [valuator])
      create(:budget_investment, :visible_to_valuators, budget: budget, valuator_groups: [valuator_group])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_link "Evaluate"
    end

    it "is shown when the assigned investments have finished valuation" do
      budget = create(:budget, :valuating)
      create(:budget_investment, :visible_to_valuators,
                                 budget: budget,
                                 valuators: [valuator],
                                 valuation_finished: true)

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_link "Evaluate"
    end

    it "is not shown when the assigned investments aren't visible to valuators" do
      budget = create(:budget, :valuating)
      create(:budget_investment, :invisible_to_valuators, budget: budget, valuators: [valuator])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).not_to have_link "Evaluate"
    end

    it "is not shown when the valuator doesn't have assigned investments" do
      budget = create(:budget, :valuating)
      create(:budget_investment, :visible_to_valuators, budget: budget)

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).not_to have_link "Evaluate"
    end

    it "is not shown when the budget hasn't reached the valuating phase" do
      budget = create(:budget, :accepting)
      create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).not_to have_link "Evaluate"
    end

    it "is shown when the valuating phase is over" do
      budget = create(:budget, :finished)
      create(:budget_investment, :visible_to_valuators, budget: budget, valuators: [valuator])

      render_inline Valuation::Budgets::RowComponent.new(budget: budget)

      expect(page).to have_link "Evaluate"
    end
  end
end
>>>>>>> 33c62ccbd7c08c99604903bc8f983f3e706ed21d
