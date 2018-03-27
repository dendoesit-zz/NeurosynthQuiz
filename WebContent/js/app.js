jQuery(document).ready(function() {
	
	$("input:radio").change(function () {$("#btn").prop("disabled", false);});
	
	var lastQuestion = $('#lastQuestion').val();
    
	viewer = new Viewer('#layer_list', '.layer_settings');
	viewer.addView('#view_axial', Viewer.AXIAL);
	viewer.addView('#view_coronal', Viewer.CORONAL);
	viewer.addView('#view_sagittal', Viewer.SAGITTAL);
	viewer.addSlider('opacity', '.slider#opacity', 'horizontal', 0, 1, 1, 0.05);
	viewer.addSlider('pos-threshold', '.slider#pos-threshold', 'horizontal', 0, 1, 0, 0.01);
	viewer.addSlider('neg-threshold', '.slider#neg-threshold', 'horizontal', 0, 1, 0, 0.01);
	viewer.addSlider("nav-xaxis", ".slider#nav-xaxis", "horizontal", 0, 1, 0.5, 0.01, Viewer.XAXIS);
	viewer.addSlider("nav-yaxis", ".slider#nav-yaxis", "vertical", 0, 1, 0.5, 0.01, Viewer.YAXIS);
	viewer.addSlider("nav-zaxis", ".slider#nav-zaxis", "vertical", 0, 1, 0.5, 0.01, Viewer.ZAXIS);
    
	viewer.addColorSelect('#select_color');
	viewer.addSignSelect('#select_sign')
	viewer.addDataField('voxelValue', '#data_current_value')
	viewer.addDataField('currentCoords', '#data_current_coords')
	viewer.addTextField('image-intent', '#image_intent')

	viewer.clear()   // Paint canvas background while images load
	images = [
		{
			'url': 'data/MNI152.nii.gz',
			'name': 'MNI152 2mm',
			'cache': false,
			'intent': 'Intensity:'
		},
		{
			'url': 'data/language_meta.json',
			'name': 'language meta-analysis',
			'positiveThreshold': 10.0,
			'negativeThreshold': -3.0,
			'intent': 'z-score:'
		},
		{
			'url': 'data/emotion_meta.nii.gz',
			'name': 'emotion meta-analysis',
			'intent': 'z-score:'
		},
		{	
			'name': 'spherical ROI',
			'data': {
				'dims': [91, 109, 91],
				'peaks': [
					{
						'x': -48,
						'y': 20,
						'z': 20, 
						'r': 6, 
						'value': 1
					}
				]
			}
		}
	]
	viewer.loadImages(images);

    // the important part
    // on button click 
    // once we check where the user was left at, we can navigate the json to that exact point
    $("#btn").on("click", getQuestions)
	function getQuestions() {
        // get data from json, example.json is the file
        var myData = JSON.parse(data);
        console.log("question number: " + lastQuestion + "out of " +  myData.length);
        if (lastQuestion >= myData.length) {
        	window.location.href = "finish.jsp";
        	return;
        }
        var xyz;
        var options = viewer.options;
        if (options == null) {
            options = {}
        }
        options["xyz"] = xyz;
        // set viewer coordinates, x , y , z
        // the last question variable needs to be modified, asking from the database for this value.
        console.log(myData[lastQuestion]);
        viewer.moveToViewerCoords(0, (myData[lastQuestion].x + 90) / 180);
        viewer.moveToViewerCoords(1, 1 - (myData[lastQuestion].y + 126) / 216);
        viewer.moveToViewerCoords(2, 1 - (myData[lastQuestion].z + 72) / 180);
        
        var method1 = myData[lastQuestion].method1
        for (var i = 0; i < method1.length; i++) {
        	$('#method1').append('<li>' + method1[i] + '</li>')
        }
        var method2 = myData[lastQuestion].method2
        for (var i = 0; i < method2.length; i++) {
        	$('#method2').append('<li>' + method2[i] + '</li>')
        }
    };
    getQuestions();
});