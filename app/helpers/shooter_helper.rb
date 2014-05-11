module ShooterHelper
  def display_weapons_for(s)
    w = [(I18n.t('activerecord.attributes.shooter.handgun') if s.handgun),
         (I18n.t('activerecord.attributes.shooter.rifle') if s.rifle),
         (I18n.t('activerecord.attributes.shooter.handgun') if s.shotgun)]
    w.compact.join(', ')
  end
end
