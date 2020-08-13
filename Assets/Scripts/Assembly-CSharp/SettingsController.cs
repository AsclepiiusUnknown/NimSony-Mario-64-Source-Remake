using UnityEngine;
using UnityEngine.PostProcessing;
using UnityEngine.UI;

public class SettingsController : MonoBehaviour
{
	public PostProcessingProfile interior;
	public PostProcessingProfile exterior;
	public PostProcessingProfile menu;
	public Text antialiasText;
	public Text bloomText;
	public Text occlusionText;
	public Text ssrText;
	public Text lightsText;
	public Text shadowsText;
}
