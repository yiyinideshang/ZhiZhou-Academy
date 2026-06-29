using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// ReaderComments:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class ReaderComments
	{
		public ReaderComments()
		{}
		#region Model
		private int _id;
		private int _courseid;
		private int _userid;
		private string _title;
		private string _comment;
		private DateTime _date;
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
		public int CourseId
		{
			set{ _courseid=value;}
			get{return _courseid;}
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
		public string Title
		{
			set{ _title=value;}
			get{return _title;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Comment
		{
			set{ _comment=value;}
			get{return _comment;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime Date
		{
			set{ _date=value;}
			get{return _date;}
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

