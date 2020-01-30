use strict; 
use warnings; 
  
sub main 
{ 
	
    my $jenkinsJobId = "$[/myPipelineRuntime/stages/validateRequirements/tasks/GetJenkinsJobLog/job/jobId]"; 
    my $jenkinsJobName = "$[/myPipelineRuntime/stages/validateRequirements/tasks/GetJenkinsJobLog/job/jobName]"; 
    my $sonarProjectVersion;
    my $sonarProjectKey;
    my $sonarProjectName;
	print "../$jenkinsJobName/\n";
	# find the file log name
	opendir(DIR, "../$jenkinsJobName/");
	my @files = grep(/GetBuildLog.*\.log$/,readdir(DIR));
	closedir(DIR);
	
	# check that we have one file
	my $fileCount = scalar @files;
	
	if($fileCount != 1) {
	 	die "There were $fileCount log files found\n";
	}

    my $jenkinsLogFile = "../$jenkinsJobName/$files[0]";
    
    open(FH, $jenkinsLogFile) or die("File $jenkinsLogFile not found"); 
      
    while(my $String = <FH>) 
    { 
        if($String =~ /Uploaded:\s+http:\/\/.*(\d+\.\d+\.\d+(-SNAPSHOT)*?)\/([a-z\-]+)-(\d+\.\d+\.\d+-\d+\.\d+-\d+)\.jar/)  
        { 
            $sonarProjectVersion = "$1"; 
        } 
        # will match project key and each segment of the key
        if($String =~ /\[INFO\]\s+Project\s+key:\s+(([a-z\-\d\.]+):([a-z\-\d]+))/) 
        { 
            $sonarProjectKey = "$1"; 
            $sonarProjectName = "$2"; 
        } 
    } 
    close(FH); 
    
    print $sonarProjectVersion . "\n";
    print $sonarProjectKey . "\n";
    print $sonarProjectName . "\n";
    
    use ElectricCommander;
	my $ec = ElectricCommander->new();
    $ec->createProperty({
   				propertyName => "/myStageRuntime/sonarProjectVersion",
          		value => $sonarProjectVersion
    		});	
	$ec->createProperty({
			propertyName => "/myStageRuntime/sonarProjectKey",
			value => $sonarProjectKey
		});	

    $ec->createProperty({
   				propertyName => "/myStageRuntime/sonarProjectName",
          		value => $sonarProjectName
    		});	
    
    
} 
main(); 
