module ApplicationHelper
  def image_path_to_product_name(image_path)
    image_path.split('_')[2..-1].join(' ').capitalize
  end
end
