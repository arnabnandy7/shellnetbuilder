<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title></title>
<script type="text/javascript" src="scripts/candidate_preferense.js"></script>
<link rel="stylesheet" href="styles/candidate_preferense.css" type="text/css" />
<style type="text/css">
.options{
margin:0 0 0 30px;

}
h3 {
color: black;
}
#pref1, #pref2, #pref3, #save_massage {
	color: black;
}
#msg {
	background:#CC3300;
	text-align:center;
	text-transform:!important;
	color:#FFFFFF;
	position:absolute;
	top:0px;
	left:0px;
	width:100%;
	height: 50px;
	display:none;
}
#msg #text {
	margin:15px 0 0 0;
}
</style>

</head>
<body id="">
<div class = "lightboxbg"></div>

<div class = "lightbox">

<img src="images/cross.png" class="close">
<p>
 
<table id="rounded-corner" class="table">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company">Select:</th>
            <th scope="col" class="rounded">College Name:</th>
            <th scope="col" class="rounded">Select:</th>
            <th scope="col" class="rounded">College Name:</th>
			<th scope="col" class="rounded">Select:</th>
			<th scope="col" class="rounded">College Name:</th>
			<th scope="col" class="rounded">Select:</th>
			<th scope="col" class="rounded">College Name:</th>
			<th scope="col" class="rounded">Select:</th>
			<th scope="col" class="rounded-q4">College Name:</th>
            
        </tr>
    </thead>
        
    <tbody>
    	<tr>
        	<td><input type="checkbox" name="Bengal College of Engineering & Technology" id="chk_bcet" value = "1" /></td>
			<td>Bengal College of Engineering & Technology</td>
			<td><input type="checkbox" name="Techno India - Hoogly" id="chk_tih" value = "2"/></td>
			<td>Techno India - Hoogly</td>
			<td><input type="checkbox" name="Heritage Institute of Technology" id="chk_heritage" value = "3"/></td>
			<td>Heritage Institute of Technology</td>
			<td><input type="checkbox" name="Institute of Science & Technology" id="chk_ist" value = "4"/></td>
			<td>Institute of Science & Technology</td>
			<td colspan=""><input type="checkbox" name="Pailan College of Management & Technology" id="chk_pailan" value = "5" /></td>
			<td>Pailan College of Management & Technology</td>
        </tr>
		<tr>
			<td><input type="checkbox" name="Techno India" id="chk_ti" value = "6" /></td>
			<td>Techno India</td>
			<td><input type="checkbox" name="Bengal Institute of Technology" id="chk_bit" value = "7"/></td>
			<td>Bengal Institute of Technology</td>
			<td><input type="checkbox" name="DSMS Business School" id="chk_dsms" value = "8" /></td>
			<td>DSMS Business School</td>
			<td><input type="checkbox" name="Narula Institute of Technology" id="chk_narula" value = "9" /></td>
			<td>Narula Institute of Technology</td>
			<td colspan=""><input type="checkbox" name="RCC Institute of Information Technology" id="chk_rcc"  value = "10"/></td>
			<td>RCC Institute of Information Technology</td>
		</tr>
    	<tr>
        	<td><input type="checkbox" name="Haldia Institute of Technology" id="chk_hit" value = "11" /></td>
			<td>Haldia Institute of Technology</td>
			<td><input type="checkbox" name="Brainware Group of Institution" id="chk_bgi" value = "12" /></td>
			<td>Brainware Group of Institution</td>
			<td><input type="checkbox" name="Netaji Subhash Engineering College" id="chk_nsec" value = "13" /></td>
			<td>Netaji Subhash Engineering College</td>
			<td><input type="checkbox" name="Dr. B. C. Roy Engineering College" id="chk_bcroy" value = "14" /></td>
			<td>Dr. B. C. Roy Engineering College</td>
			<td colspan=""><input type="checkbox" name="Bankura Unnyani Institute of Engineering" id="chk_buie" value = "15" /></td>
			<td>Bankura Unnyani Institute of Engineering</td>
        </tr>
		<tr>
        	<td><input type="checkbox" name="Future Institute of Engineering & Management" id="chk_fiem" value="16"/></td>
			<td>Future Institute of Engineering & Management</td>
			<td><input type="checkbox" name="Camellia Institute of Technology" id="chk_camit" value="17" /></td>
			<td>Camellia Institute of Technology</td>
			<td><input type="checkbox" name="Techno India College of Technology" id="chk_tict" value="18" /></td>
			<td>Techno India College of Technology</td>
			<td><input type="checkbox" name="Regent Education & Research Foundation Group of Institution" id="chk_regent" value="19" /></td>
			<td>Regent Education & Research Foundation Group of Institution</td>
			<td colspan=""><input type="checkbox" name="Seacom Engineering College" id="chk_seacom" value="20" /></td>
			<td>Seacom Engineering College</td>
        </tr>
		<tr>
        	<td><input type="checkbox" name="Academy OF Technology" id="chk_aot" value="21" /></td>
			<td>Academy OF Technology</td>
			<td><input type="checkbox" name="Asansol Engineering College" id="chk_aec" value="22" /></td>
			<td>Asansol Engineering College</td>
			<td><input type="checkbox" name="Gurunanak Institute of Technology" id="chk_git" value="23" /></td>
			<td>Gurunanak Institute of Technology</td>
			<td><input type="checkbox" name="B.P. Poddar Institute of Management & Technology" id="chk_bppimt" value="24" /></td>
			<td>B.P. Poddar Institute of Management & Technology</td>
			<td colspan=""><input type="checkbox" name="Meghnad Saha Institute of Technology" id="chk_msit" value="25" /></td>
			<td>Meghnad Saha Institute of Technology</td>
        </tr>
		<tr>
        	<td><input type="checkbox" name="Kalyani Govt. Engineering College" id="chk_kgec" value="26" /></td>
			<td>Kalyani Govt. Engineering College</td>
			<td><input type="checkbox" name="MCKV Institute of Engineering" id="chk_mckv" value="27" /></td>
			<td>MCKV Institute of Engineering</td>
			<td><input type="checkbox" name="Greater Kolkata College of Engineering & Management" id="chk_gkcem" value="28" /></td>
			<td>Greater Kolkata College of Engineering & Management</td>
			<td><input type="checkbox" name="Siliguri Institute of Technology" id="chk_sit" value="29" /></td>
			<td>Siliguri Institute of Technology</td>
			<td colspan=""><input type="checkbox" name="Calcutta Institute of Technology" id="chk_cit" value="30" /></td>
			<td>Calcutta Institute of Technology</td>
        </tr>
		<tr>
        	<td><input type="checkbox" name="JIS College of Engineering" id="chk_jis" value="31" /></td>
			<td>JIS College of Engineering</td>
			<td><input type="checkbox" name="Management Institute of Durgapur" id="chk_mid" value="32" /></td>
			<td>Management Institute of Durgapur</td>
			<td><input type="checkbox" name="St. Mary's Technical Campus" id="chk_stmt" value="33" /></td>
			<td>St. Mary's Technical Campus</td>
			<td><input type="checkbox" name="Burdwan University" id="chk_bu" value="34" /></td>
			<td>Burdwan University</td>
			<td><input type="checkbox" name="Calcutta University" id="chk_cu" value="35" /></td>
			<td>Calcutta University</td>
        </tr>
		<tr>
        	<td><input type="checkbox" name="Jadavpur University" id="chk_ju" value="36" /></td>
			<td>Jadavpur University</td>
			<td><input type="checkbox" name="Kalyani University" id="chk_ku" value="37" /></td>
			<td>Kalyani University</td>
			<td><input type="checkbox" name="North Bengal University" id="chk_nbu" value="38" /></td>
			<td>North Bengal University</td>
			<td><input type="checkbox" name="Vidyasagar University" id="chk_vu" value="39" /></td>
			<td>Vidyasagar University</td>
        </tr>
    </tbody>
	
	<!--<tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"></td>
			<td class="rounded-foot-right"></td>
        </tr>
	</tfoot>-->
	
</table><br/>

<label id="display1" style = "display:none"></label><br>
<label id="display2" style = "display:none"></label><br>
<label id="display3" style = "display:none"></label><br>

<label id="display4" style = "display:none"></label><br>
<label id="display5" style = "display:none"></label><br>
<label id="display6" style = "display:none"></label><br>

<input type="submit" value="Save Preferrences" class = "pref_btn"/><span id = "counter"></span>
</p>

<div id = "boxbg"></div>

</div>	

<div id = "box">
<div id = "msg">
	<div id = "text">Plese Chooose Distinct Value..</div>
</div>
<img src="images/cross.png" class="close1">
<h3 align="center">Select Your college Preference</h3><br>
<hr>

<table>
	<tr>
		<td><span id="pref1"></span></td>
		<td><select name="college" class="options" id="p1">
	<option value="select">Select</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
</select></td>
	</tr>
	<tr>
		<td><span id="pref2"></span></td>
		<td><select  name="college" class="options" id="p2">
	<option value="select">Select</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
</select></td>
	</tr>
	<tr>
		<td><span id="pref3"></span></td>
		<td><select class="options" name="college" id="p3">
	<option value="select">Select</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
</select></td>
	</tr>
</table>
<!--<input type="submit" id  ="save_pref" value="Save" />--><span id = "save_massage"></span>
<a  href = "#" id = "save_pref" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>
</div>

</body>
</html>