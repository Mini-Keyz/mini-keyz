# frozen_string_literal: true

# Source: https://gist.github.com/mattetti/1015948

# Parameters:
# rate (%/year) => the interest rate for the loan
# nper (unit) => the total number of payments for the loan ==> will mostly be months
# pv (euros) => the present value, or the total amount that a series of future payments is worth now; also known as the principal.
# fv (euros) => the future value, or a cash balance you want to attain after the last payment is made. If fv is omitted, it is assumed to be 0 (zero), that is, the future value of a loan is 0.
# type (nber) => the number 0 or 1 and indicates when payments are due (0 = beginning of the period / 1 = end of the period)
module CreditFormulas
  def pmt(rate, nper, pv, fv = 0, type = 0)
    ((-pv * pvif(rate, nper) - fv) / ((1.0 + rate * type) * fvifa(rate, nper)))
  end

  def ipmt(rate, per, nper, pv, fv = 0, type = 0)
    p = pmt(rate, nper, pv, fv, 0)
    ip = -(pv * pow1p(rate, per - 1) * rate + p * pow1pm1(rate, per - 1))
    type.zero? ? ip : ip / (1 + rate)
  end

  def ppmt(rate, per, nper, pv, fv = 0, type = 0)
    p = pmt(rate, nper, pv, fv, type)
    ip = ipmt(rate, per, nper, pv, fv, type)
    p - ip
  end

  protected

  def pow1pm1(x, y)
    x <= -1 ? ((1 + x)**y) - 1 : Math.exp(y * Math.log(1.0 + x)) - 1
  end

  def pow1p(x, y)
    x.abs > 0.5 ? ((1 + x)**y) : Math.exp(y * Math.log(1.0 + x))
  end

  def pvif(rate, nper)
    pow1p(rate, nper)
  end

  def fvifa(rate, nper)
    rate.zero? ? nper : pow1pm1(rate, nper) / rate
  end
end
