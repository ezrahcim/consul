require "rails_helper"

describe MachineLearning::CommentsSummaryComponent do
  let(:commentable) { double(summary_comment: double(body: "There's a general agreement")) }
  let(:component) { MachineLearning::CommentsSummaryComponent.new(commentable) }

  before do
    Setting["feature.machine_learning"] = true
    Setting["machine_learning.comments_summary"] = true
  end

  it "is displayed when the setting is enabled" do
    render_inline component

    expect(page).to have_content "Comments summary"
    expect(page).to have_content "There's a general agreement"
    expect(page).to have_content "Content generated by AI / Machine Learning"
  end

  it "is not displayed when the setting is disabled" do
    Setting["machine_learning.comments_summary"] = false

    render_inline component

    expect(page).not_to be_rendered
  end

  it "is not displayed when the machine learning feature is disabled" do
    Setting["feature.machine_learning"] = false

    render_inline component

    expect(page).not_to be_rendered
  end

  it "is not displayed when there's no summary" do
    commentable = double(summary_comment: double(body: ""))

    render_inline MachineLearning::CommentsSummaryComponent.new(commentable)

    expect(page).not_to be_rendered
  end
end
