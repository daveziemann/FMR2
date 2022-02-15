Extension { #name : #SettingTreeBuilder }

{ #category : #'*FMR' }
SettingTreeBuilder >> fmrsettings [
	"Process a <fmrsettings> pragma"

	currentPragma methodClass instanceSide
		perform: currentPragma methodSelector
		with: self
]
