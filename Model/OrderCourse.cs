using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// OrderCourse:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class OrderCourse
	{
		public OrderCourse()
		{}
		#region Model
		private int _id;
		private int _orderid;
		private int _courseid;
		private string _beiyong1;
		private string _beiyong2;
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
		public int OrderID
		{
			set{ _orderid=value;}
			get{return _orderid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int CourseID
		{
			set{ _courseid=value;}
			get{return _courseid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string beiyong1
		{
			set{ _beiyong1=value;}
			get{return _beiyong1;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string beiyong2
		{
			set{ _beiyong2=value;}
			get{return _beiyong2;}
		}
		#endregion Model

	}
}

