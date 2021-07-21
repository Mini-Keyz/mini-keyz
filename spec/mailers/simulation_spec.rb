require 'rails_helper'

RSpec.describe SimulationMailer, type: :mailer do
  describe '#send_it_to_me' do
    let(:mail) { SimulationMailer.send_it_to_me }

    it 'renders the headers' do
      expect(mail.subject).to eq('send_it_to_me')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
