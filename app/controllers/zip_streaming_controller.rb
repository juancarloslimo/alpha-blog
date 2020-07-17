class ZipStreamingController < ApplicationController
  include ActionController::Live
  before_action :set_article

  def download
    zipname = "#{@article.slug}.zip"
    disposition = ActionDispatch::Http::ContentDisposition.format(disposition: 
    "attachment", filename: zipname)

    response.headers["Content-Disposition"] = disposition
    response.headers["Content-Type"] = "application/zip"
    response.headers.delete("Content-Length")
    response.headers["Cache-Control"] = "no-cache"
    response.headers["Last-Modified"] = Time.now.httpdate.to_s
    response.headers["X-Accel-Buffering"] = "no"

    writer = ZipTricks::BlockWrite.new do |chunk| 
      response.stream.write(chunk)
    end
    ZipTricks::Streamer.open(writer) do |zip|
      @article.document.each do |doc|
        zip.write_deflated_file(doc.filename.to_s) do |file_writer|
          doc.blob.download do |chunk|
            file_writer << chunk
          end
        end
      end
    end
  ensure
    response.stream.close
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end