import axios from '@/libs/api.request'

export const getAllCatalog = (pid) => {
  return axios.request({
    url:  'catalogs/all',
    params: {
      pid
    },
    method: 'get'
  })
}

export const getCatalogByPid = (pid) => {
  return axios.request({
    url:   'catalogs/sons',
    params: {
      pid
    },
    method: 'get'
  })
}

export const getCatalogById = (id) => {
  return axios.request({
    url:   'catalogs/'+id,
    method: 'get'
  })
}

export const checkCatalogCode = (code) => {
  return axios.request({
    url:   'catalogs/code',
    params: {
      code
    },
    method: 'get'
  })
}

export const addCatalog = (catalog) => {
  return axios.request({
    url:   'catalogs',
    data: catalog,
    method: 'post'
  })
}

export const updateCatalog = (catalog) => {
  return axios.request({
    url:   'catalogs/'+catalog.id,
    data: catalog,
    method: 'put'
  })
}

export const deleteCatalogById = (id) => {
  return axios.request({
    url:   'catalogs/'+id,
    method: 'delete'
  })
}