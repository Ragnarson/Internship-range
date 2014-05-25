module ShootingHelper
  def build_fields(shooting)
    shooting.explode_target.virtual_attributes.each {|shot| yield(shot)}
  end
end
