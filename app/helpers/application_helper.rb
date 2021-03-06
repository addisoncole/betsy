module ApplicationHelper
  def random_emoji
    emojis = ["\u{1F914}", "\u{1F920}", "\u{1F389}", "\u{1F38A}", "\u{1F380}", "\u{1F451}", "\u{1F4F1}", "\u{1F4BF}", "\u{1F4A1}", "\u{1F4B6}", "\u{1F4B8}", "\u{1F513}", "\u{1F52B}", "\u{1F4E1}", "\u{1F489}", "\u{1F48A}", "\u{1F6CB}", "\u{1F6BD}", "\u{1F6C1}", "\u{1F6AC}", "\u{1F3E7}", "\u{1F6BC}", "\u{2623}", "\u{2622}", "\u{1F51C}", "\u{1F51D}", "\u{2638}", "\u{264F}", "\u{267B}", "\u{1F484}", "\u{1F48D}", "\u{1F48E}", "\u{1F460}", "\u{1F52E}", "\u{1F38F}", "\u{1F30A}", "\u{1F4A7}", "\u{1F525}", "\u{2604}", "\u{26A1}", "\u{1F308}", "\u{1F31D}", "\u{1F31A}", "\u{1F6F8}", "\u{1F3DD}", "\u{1F30B}", "\u{1F30D}", "\u{1F310}", "\u{1F52A}", "\u{1F942}", "\u{1F378}", "\u{1F37C}", "\u{1F36F}", "\u{1F36D}", "\u{1F36C}", "\u{1F382}", "\u{1F36A}", "\u{1F369}", "\u{1F367}", "\u{1F991}", "\u{1F354}", "\u{1F35F}", "\u{1F355}", "\u{1F9C0}", "\u{1F344}", "\u{1F336}", "\u{1F955}", "\u{1F352}", "\u{1F340}", "\u{1F335}", "\u{1F33C}", "\u{1F40C}", "\u{1F419}", "\u{1F40D}", "\u{1F425}", "\u{1F423}", "\u{1F445}", "\u{1F441}", "\u{1F440}", "\u{1F444}", "\u{1F9E0}", "\u{1F44C}", "\u{1F4A5}", "\u{1F4AF}", "\u{1F5A4}", "\u{1F49C}", "\u{1F499}", "\u{1F49A}", "\u{1F49B}", "\u{1F9E1}", "\u{2764}", "\u{1F495}", "\u{1F496}", "\u{1F48B}", "\u{1F640}", "\u{1F63B}", "\u{1F47D}", "\u{1F47B}", "\u{1F608}", "\u{1F624}", "\u{1F613}", "\u{1F631}", "\u{1F62D}", "\u{1F633}", "\u{1F9D0}", "\u{1F913}", "\u{1F920}", "\u{1F92F}", "\u{1F635}", "\u{1F92E}", "\u{1F637}", "\u{1F644}", "\u{1F92B}", "\u{1F914}", "\u{1F917}", "\u{1F911}", "\u{1F61C}", "\u{1F60B}", "\u{1F60D}", "\u{1F607}", "\u{1F602}"]
    return emojis.sample.html_safe
  end

  def number_of_paid_orders
    if da_ordah_splittah_numoratorrr("paid", @logged_in_user.merchant_orders) != 0
      num = da_ordah_splittah_numoratorrr("paid", @logged_in_user.merchant_orders)
      return ("(#{num})").html_safe
    end
  end
end
