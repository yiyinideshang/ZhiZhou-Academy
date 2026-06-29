using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Course:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Course
	{
		public Course()
		{}
		#region Model
		private int _id;
		private string _title;
		private string _author;
		private int _categoryid;
		private int? _clicks;
		private DateTime? _publishdate;
		private int? _duration;
		private string _contentdescription;
		private string _aurhordescription;
		private string _editorcomment;
		private string _toc;
		private int? _registration;
		private int _isshow;
		private decimal? _price;
		private DateTime? _startdate;
		private int _isRecommended;
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
		public string Title
		{
			set{ _title=value;}
			get{return _title;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Author
		{
			set{ _author=value;}
			get{return _author;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int CategoryId
		{
			set{ _categoryid=value;}
			get{return _categoryid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? Clicks
		{
			set{ _clicks=value;}
			get{return _clicks;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? PublishDate
		{
			set{ _publishdate=value;}
			get{return _publishdate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? Duration
		{
			set{ _duration=value;}
			get{return _duration;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ContentDescription
		{
			set{ _contentdescription=value;}
			get{return _contentdescription;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string AurhorDescription
		{
			set{ _aurhordescription=value;}
			get{return _aurhordescription;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string EditorComment
		{
			set{ _editorcomment=value;}
			get{return _editorcomment;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string TOC
		{
			set{ _toc=value;}
			get{return _toc;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? Registration
		{
			set{ _registration=value;}
			get{return _registration;}
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
		public decimal? Price
		{
			set{ _price=value;}
			get{return _price;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartDate
		{
			set{ _startdate=value;}
			get{return _startdate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int IsRecommended
		{
			set{ _isRecommended=value;}
			get{return _isRecommended;}
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

