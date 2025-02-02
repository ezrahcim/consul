Ahoy.geocode = false
Ahoy.api = true
Ahoy.server_side_visits = :when_needed

# Most code comes from:
# https://github.com/ankane/ahoy/blob/3661b7f9a/docs/Ahoy-2-Upgrade.md
class Ahoy::Store < Ahoy::DatabaseStore
  def track_visit(data)
    data[:id] = ensure_uuid(data.delete(:visit_token))
    data[:visitor_id] = ensure_uuid(data.delete(:visitor_token))
    super(data)
  end

  def track_event(data)
    data[:id] = ensure_uuid(data.delete(:event_id))
    data[:ip] = request.ip
    super(data)
  end

  def visit
    @visit ||= visit_model.find_by(id: ensure_uuid(ahoy.visit_token)) if ahoy.visit_token
  end

  def visit_model
    Visit
  end

  UUID_NAMESPACE = UUIDTools::UUID.parse("a82ae811-5011-45ab-a728-569df7499c5f")

  def ensure_uuid(id)
    UUIDTools::UUID.parse(id).to_s
  rescue
    UUIDTools::UUID.sha1_create(UUID_NAMESPACE, id).to_s
  end

  def exclude?
    false
  end
end
