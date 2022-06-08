require 'rails_helper'

describe "Number Builder", type: :feature do
  before { create_invoice(number: 4684.31) }

  context "without options" do
    before do
      register_index(Invoice) do
        number_column :number
      end

      visit admin_invoices_path
    end

    it "shows formatted number" do
      expect(page.text).to match("4,684.31")
    end
  end

  context "passing rails number helper options" do
    before do
      register_index(Invoice) do
        number_column :number, as: :currency, unit: "€", separator: ",", delimiter: '.'
      end

      visit admin_invoices_path
    end

    it "applies rails number helper options" do
      expect(page.text).to match("€4.684,31")
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        number_row(:number, as: :human) do
          invoice.number
        end
      end

      visit admin_invoice_path(@invoice)
    end

    it "shows formatted number" do
      expect(page.text).to match("4.68 Thousand")
    end
  end

  context "using a custom label" do
    before do
      register_show(Invoice) do
        number_row("Mi número", :number, as: :percentage)
      end

      visit admin_invoice_path(@invoice)
    end

    it "shows custom label" do
      expect(page).to have_content("Mi Número")
    end
  end
end
