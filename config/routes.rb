Rails.application.routes.draw do
  get 'outlines/:date' => 'outlines#show', as: :outline
  root 'outlines#today'
end
