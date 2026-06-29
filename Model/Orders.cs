using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Orders:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Orders
	{
		public Orders()
		{}
		#region Model
		private int _id;
		private DateTime _orderdate;
		private int _userid;
		private decimal _totalpirce;
		private string _beiyong;
		/// <summary>
		/// 
		/// </summary>
		public int Id
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime OrderDate
		{
			set{ _orderdate=value;}
			get{return _orderdate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int UserId
		{
			set{ _userid=value;}
			get{return _userid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public decimal TotalPirce
		{
			set{ _totalpirce=value;}
			get{return _totalpirce;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string beiyong
		{
			set{ _beiyong=value;}
			get{return _beiyong;}
		}
		#endregion Model

	}
}

