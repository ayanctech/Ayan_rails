require 'prawn'
require 'prawn/table'

class SubscribersController < ApplicationController

  def index
    @subscribers = Subscriber.all
  end

  def download_pdf
    if Subscriber.count<50
      addSubscribers()
    else
      @subscribers=Subscriber.all.order("name ASC")
    end
      respond_to do |format|
        format.pdf do
          pdf = Prawn::Document.new
          table_data = Array.new
          table_data << ["Name","E-mail","Phone"]
          @subscribers.each do |p|
              table_data << [p.name, p.email,p.phone]
          end
          pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
          send_data pdf.render, filename: 'test.pdf', type: 'application/pdf', :disposition => 'inline'
        end
      end
  end

  def download_csv
    if Subscriber.count<50
      addSubscribers()
    else
      @subscribers=Subscriber.all.order("name ASC")
    end
    respond_to do |format|
      format.html
      format.csv { send_data @subscribers.to_csv, filename: "subscribers-#{Date.today}.csv" }
    end
  end

  def sendMail
    if Subscriber.count<50
      addSubscribers()
    else
      @subscribers=Subscriber.all.order("name ASC")
    end

    if AdminMailer.data_table(@subscribers).deliver
      redirect_to (root_path), flash: { notice: "Mail sent"}
    else
      redirect_to (root_path), flash: { notice: "Mail sent"}
    end
  end

  private
  def addSubscribers
    Subscriber.delete_all
    (1..50).each do |i|
      nam=(0...10).map { ('a'..'z').to_a[rand(26)] }.join
      mail=nam+"@gmail.com"
      phn=rand(10 ** 10)
      u=Subscriber.new(:name=>nam,:email=>mail,:phone=>phn)
      u.save
    end
  end
end
