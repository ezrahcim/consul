<<<<<<< HEAD
class RemoteTranslation < ApplicationRecord
  belongs_to :remote_translatable, polymorphic: true

  validates :remote_translatable_id, presence: true
  validates :remote_translatable_type, presence: true
  validates :locale, presence: true
  validates :locale, inclusion: { in: ->(_) { RemoteTranslations::Microsoft::AvailableLocales.available_locales }}
  validate :already_translated_resource
  after_create :enqueue_remote_translation

  def enqueue_remote_translation
    RemoteTranslations::Caller.new(self).delay.call
  end

  def self.remote_translation_enqueued?(remote_translation)
    where(remote_translatable_id: remote_translation["remote_translatable_id"],
          remote_translatable_type: remote_translation["remote_translatable_type"],
          locale: remote_translation["locale"],
          error_message: nil).any?
  end

  def already_translated_resource
    if remote_translatable&.translations&.where(locale: locale).present?
      errors.add(:locale, :already_translated)
    end
  end
end
=======
class RemoteTranslation < ApplicationRecord
  belongs_to :remote_translatable, polymorphic: true

  validates :remote_translatable_id, presence: true
  validates :remote_translatable_type, presence: true
  validates :locale, presence: true
  validates :locale, inclusion: { in: ->(_) { RemoteTranslations::Microsoft::AvailableLocales.available_locales }}
  validate :already_translated_resource
  after_create :enqueue_remote_translation

  def enqueue_remote_translation
    RemoteTranslations::Caller.new(self).delay.call
  end

  def self.for(*args)
    resources_groups(*args).flatten.select { |resource| translation_empty?(resource) }.map do |resource|
      new(remote_translatable: resource, locale: I18n.locale)
    end
  end

  def self.resources_groups(*args)
    feeds = args.find { |arg| arg&.first.class == Widget::Feed } || []

    args.compact - [feeds] + feeds.map(&:items)
  end

  def self.translation_empty?(resource)
    resource.class.translates? && resource.translations.where(locale: I18n.locale).empty?
  end

  def self.create_all(remote_translations_params)
    remote_translations_params.map do |remote_translation_params|
      new(remote_translation_params)
    end.reject(&:already_translated?).reject(&:enqueued?).each(&:save!)
  end

  def already_translated_resource
    if already_translated?
      errors.add(:locale, :already_translated)
    end
  end

  def enqueued?
    self.class.where(remote_translatable: remote_translatable,
                     locale: locale,
                     error_message: nil).any?
  end

  def already_translated?
    remote_translatable&.translations&.where(locale: locale).present?
  end
end
>>>>>>> 33c62ccbd7c08c99604903bc8f983f3e706ed21d
