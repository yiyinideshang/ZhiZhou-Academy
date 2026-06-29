using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Categories:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Categories
	{
		public Categories()
		{}
		#region Model
		private int _id;
		private string _name;
		private int _isshow;
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
		public string Name
		{
			set{ _name=value;}
			get{return _name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int IsShow
		{
			set{ _isshow=value;}
			get{return _isshow;}
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

