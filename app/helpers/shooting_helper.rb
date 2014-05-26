module ShootingHelper
  def build_fields(shooting)
    shooting.explode_target.each {|shot| yield(shot)}
  end
end
