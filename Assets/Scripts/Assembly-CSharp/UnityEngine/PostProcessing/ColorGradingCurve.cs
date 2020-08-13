using System;
using UnityEngine;

namespace UnityEngine.PostProcessing
{
	[Serializable]
	public class ColorGradingCurve
	{
		public AnimationCurve curve;
		[SerializeField]
		private bool m_Loop;
		[SerializeField]
		private float m_ZeroValue;
		[SerializeField]
		private float m_Range;
	}
}
