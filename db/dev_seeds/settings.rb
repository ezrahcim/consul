section "Creating Settings" do
  Setting.reset_defaults

  {
    "facebook_handle": "CONSUL",
    "feature.featured_proposals": "true",
    "feature.map": "true",
    "instagram_handle": "CONSUL",
    "meta_description": "Citizen participation tool for an open, "\
                        "transparent and democratic government",
    "meta_keywords": "citizen participation, open government",
    "meta_title": "CONSUL",
    "proposal_code_prefix": "MAD",
    "proposal_notification_minimum_interval_in_days": 0,
    "telegram_handle": "CONSUL",
    "twitter_handle": "@consul_dev",
    "twitter_hashtag": "#consul_dev",
    "votes_for_proposal_success": "100",
    "youtube_handle": "CONSUL"
  }.each do |name, value|
    Setting[name] = value
  end
end
