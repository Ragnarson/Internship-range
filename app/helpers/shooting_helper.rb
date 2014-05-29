module ShootingHelper
  def build_fields(shooting)
    shooting.explode_target.each_with_index {|shot, index| yield(index+1, shot)}
  end
end
