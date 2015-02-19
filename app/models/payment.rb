class Payment < ActiveRecord::Base
  belongs_to  :user
  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "micro280991-facilitator@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "http://demo.anakpajak.com#{return_path}",
        invoice: id,
        amount: self.amount ,
        item_name: "Pajak",
        notify_url: "http://demo.anakpajak.com/hook"
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
