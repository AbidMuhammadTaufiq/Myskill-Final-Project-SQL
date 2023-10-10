CREATE TABLE IF NOT EXISTS payment_detail (
      id_payment INT PRIMARY KEY,
	payment_method VARCHAR(50)
);
INSERT INTO payment_detail VALUES
(1,'cod'),
(2,'jazzvoucher'),
(3,'customercredit'),
(4,'Payaxis'),
(5,'jazzwallet'),
(6,'easypay_voucher'),
(7,'Easypay'),
(8,'ublcreditcard'),
(9,'mygateway'),
(10,'mcblite'),
(11,'cashatdoorstep'),
(12,'internetbanking'),
(13,'Easypay_MA'),
(14,'productcredit'),
(15,'marketingexpense'),
(16,'financesettlement');