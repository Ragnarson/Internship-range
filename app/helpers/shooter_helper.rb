module ShooterHelper
  def display_weapons_for(s)
    w = [(I18n.t('activerecord.attributes.shooter.handgun') if s.handgun),
         (I18n.t('activerecord.attributes.shooter.rifle') if s.rifle),
         (I18n.t('activerecord.attributes.shooter.shotgun') if s.shotgun)].compact
    w.blank? ? I18n.t('shooters.blank') : w.join(', ') 
  end
end
