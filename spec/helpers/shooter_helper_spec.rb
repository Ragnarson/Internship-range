require 'spec_helper'

describe ShooterHelper do
  let(:shooter){create(:shooter, handgun: true, rifle: true)}
  describe '#display_weapons_for' do
    it 'returns list of available weapons for shooter' do
      expect(display_weapons_for(shooter)).to eq(
        "#{t('activerecord.attributes.shooter.handgun')}, " + 
        t('activerecord.attributes.shooter.rifle'))
    end

    context 'if shooter does not have any available weapon' do
      before{ shooter.update_attributes(handgun: false, rifle: false) }
      it 'returns placeholder' do
        expect(display_weapons_for(shooter)).to eq(t('shooters.blank'))
      end
    end
  end
end
