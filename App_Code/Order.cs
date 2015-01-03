using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

    public class Order
    {
        public int      OrderID { get; set; }
        public DateTime OrderDate { get; set; }
        public string   InvoiceNo { get; set; }
        public Double   OrderAmount { get; set; }
        public int      ClientID { get; set; }
        public int      MemberID { get; set; }
        public int      OrderStatusID { get; set; }
        public int      CenterID { get; set; }
        public string   BankName { get; set; }
        public string   CheckNo { get; set; }
        public DateTime CheckDate { get; set; }
        public Double   BankAmount { get; set; }
        public int      ProjectYear { get; set; }

    }

