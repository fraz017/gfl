class WelcomeController < ApplicationController
	before_action :authenticate_user!
	layout "reports"
  def index
  	# Cases Part
  	@reports = Case.where('Date(created_at) > ? and Date(created_at) <= ?',(Date.today-7.days).strftime("%F"), Date.today.strftime("%F")).group_by{ |u| u.created_at.to_date } 
    @points = Array.new
    @points = (Date.today-6.days..Date.today).map{|d| d.strftime("%A")} if @reports.blank?
		@title = (Date.today-6.days..Date.today).map{|d| d.strftime("%d-%m-%Y")}

		states = {pending: 0, rejected: 1, open: 2, closed: 3}
		@series = Array.new
		states.each{|k, v| temp=Hash.new; temp["name"]=k.to_s.titleize; temp["data"]=Array.new(@reports.keys.present? ? @reports.keys.count : 1, 0); @series.push(temp) }
		@reports.each_with_index do |(k, v), index|
			@points.push(k.strftime("%A"))			
			v.group_by(&:state_cd).each do |k, v|
				@series.select{|s| s["name"]==states.invert[k.to_i].to_s.titleize}.first["data"][index] = v.length
			end
		end

		# Donations Part
		@dreports = Case.where('Date(created_at) > ? and Date(created_at) <= ?',(Date.today-7.days).strftime("%F"), Date.today.strftime("%F")).group_by{ |u| u.created_at.to_date } 
    @dpoints = (Date.today-6.days..Date.today).map{|d| d.strftime("%A")}
		@dtitle = (Date.today-6.days..Date.today).map{|d| d.strftime("%d-%m-%Y")}

		@dseries = Array.new
		data = Array.new
		d = Hash.new
		d["name"] = "Total Funds"
		d["pointWidth"] = 38
		d["data"] = Array.new(@dpoints.count, 0)
		@dpoints.each_with_index do |day, i|
			value = @dreports.select{|k, v| k.strftime("A")==d}.first
			d["data"][i] = value.try(:sum).try(&:amount).to_f
		end
		@dseries.push(d)
		
  end

  def cases
  	states = {pending: 0, rejected: 1, open: 2, closed: 3}
		@series = Array.new
		@points = Array.new
  	if !params[:month].present?
			@reports = Case.where('Date(created_at) > ? and Date(created_at) <= ?',(Date.today-7.days).strftime("%F"), Date.today.strftime("%F")).group_by{ |u| u.created_at.to_date } 
	    @points = (Date.today-6.days..Date.today).map{|d| d.strftime("%A")} if @reports.blank?	  	
	  	@title = (Date.today-6.days..Date.today).map{|d| d.strftime("%d-%m-%Y")}
	  	states.each{|k, v| temp=Hash.new; temp["name"]=k.to_s.titleize; temp["data"]=Array.new(@reports.keys.present? ? @reports.keys.count : 1, 0); @series.push(temp) }
	  else
	  	@reports = Case.where('Extract(month from created_at) > ? and Extract(month from created_at) <= ? and deleted=false',(Date.today-params[:month].to_i.month).strftime("%m"),Date.today.strftime("%m")).group_by{ |u| u.created_at.beginning_of_month }
	  	states.each{|k, v| temp=Hash.new; temp["name"]=k.to_s.titleize; temp["data"]=Array.new(@reports.keys.present? ? @reports.keys.count : 1, 0); @series.push(temp) }
	  	@title = @reports.map{|s| s[0].strftime("%B")} if @reports.present?
	  	@title = [(Date.today- params[:month].to_i.month).strftime("%B"), Date.today.strftime("%B")] if @reports.blank?
	  end	
		@reports.each_with_index do |(k, v), index|
			@points.push(k.strftime("%B"))			
			v.group_by(&:state_cd).each do |k, v|
				@series.select{|s| s["name"]==states.invert[k.to_i].to_s.titleize}.first["data"][index] = v.length
			end
		end
  	respond_to do |format|
  		format.js
  	end
  end

  def donations
  	if params[:month].present?
	  	@dreports = Donation.where('Extract(month from created_at) > ? and Extract(month from created_at) <= ?',(Date.today-params[:month].to_i.month).strftime("%m"),Date.today.strftime("%m")).group_by{ |u| u.created_at.beginning_of_month }
	  	@dpoints = Array.new
	  	@dpoints = [(Date.today- params[:month].to_i.month).strftime("%B"), Date.today.strftime("%B")] if @dreports.blank?
	  	@dseries = Array.new
	  	data = Hash.new
			data["name"] = "Total Funds"
			data["data"] = Array.new(@dpoints.present? ? @dpoints.count : @dreports.keys.count, 0)
			data["pointWidth"] = 28
			@dtitle = [(Date.today- params[:month].to_i.month).strftime("%B"), Date.today.strftime("%B")]
	  	@dreports.each_with_index do |(k, v), index|				
				@dpoints.push(k.strftime("%B"))
				data["data"][index] = v.sum(&:amount)
			end
			@dseries.push(data)
		else
			@dreports = Case.where('Date(created_at) > ? and Date(created_at) <= ?',(Date.today-7.days).strftime("%F"), Date.today.strftime("%F")).group_by{ |u| u.created_at.to_date } 
	    @dpoints = (Date.today-6.days..Date.today).map{|d| d.strftime("%A")} if @reports.blank?
			@dtitle = (Date.today-6.days..Date.today).map{|d| d.strftime("%d-%m-%Y")}
			@dseries = Array.new
			data = Array.new
			d = Hash.new
			d["name"] = "Total Funds"
			d["pointWidth"] = 28
			d["data"] = Array.new(@dpoints.count, 0)
			@dpoints.each_with_index do |day, i|
				value = @dreports.select{|k, v| k.strftime("A")==d}.first
				d["data"][i] = value.try(:sum).try(&:amount).to_f
			end
			@dseries.push(d)
		end	
  	respond_to do |format|
  		format.js
  	end
  end
end
